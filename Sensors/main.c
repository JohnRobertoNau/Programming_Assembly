#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"
extern void *get_operations(void **);

// Functie care printeaza elementele senzorului de la un anumit index
void print_simple(sensor *sensor_array, int nr_sensors, int index)
{
	// se verifica daca indexul este in range
	if (index < 0 || index >= nr_sensors) {
		printf("Index not in range!\n");
		return;
	}
	// verificam daca senzorul e de tip TIRE
	if (sensor_array[index].sensor_type == TIRE) {
		printf("Tire Sensor\n");

		tire_sensor *tire = (tire_sensor *) sensor_array[index].sensor_data;
		printf("Pressure: %.2f\n", tire->pressure);
		printf("Temperature: %.2f\n", tire->temperature);
		printf("Wear Level: %d%%\n", tire->wear_level);
		if (tire->performace_score == 0) {
			printf("Performance Score: Not Calculated\n");
		} else {
			printf("Performance Score: %d\n", tire->performace_score);
		}
	} else { // daca este de tip PMU
		printf("Power Management Unit\n");
		power_management_unit *pmu = (power_management_unit *)
		sensor_array[index].sensor_data;
		printf("Voltage: %.2f\n", pmu->voltage);
		printf("Current: %.2f\n", pmu->current);
		printf("Power Consumption: %.2f\n", pmu->power_consumption);
		printf("Energy Regen: %d%%\n", pmu->energy_regen);
		printf("Energy Storage: %d%%\n", pmu->energy_storage);
	}
}

// Functie care sterge un senzor de la un anumit index
void deleteSensor(sensor **sensor_array, int *nr_sensors, int index)
{
	int i = 0;

	// se elibereaza memoria
	free((*sensor_array)[index].sensor_data);
	free((*sensor_array)[index].operations_idxs);

	// se "muta" la stanga senzorii de dupa cel sters
	for (i = index; i < (*nr_sensors) - 1; i++) {
		(*sensor_array)[i] = (*sensor_array)[i + 1];
	}
	(*nr_sensors)--;

	//se realoca memoria
	(*sensor_array) = realloc((*sensor_array),
	(*nr_sensors) * sizeof(sensor));
}

/*
* Functie care verifica daca senzorul contine valori eronate
* si daca contine le sterge
*/
void clear(sensor **sensor_array, int *nr_sensors)
{
	int i = 0;

	// se va verifica daca senzorii au valori eronate
	for (i = (*nr_sensors) - 1; i >= 0; i--) {
		if ((*sensor_array)[i].sensor_type == TIRE) {
			tire_sensor *tire = (tire_sensor *) (*sensor_array)[i].sensor_data;
			if ((tire->pressure < 19 || tire->pressure > 28)
			|| (tire->temperature < 0 || tire->temperature > 120)
			|| (tire->wear_level < 0 || tire->wear_level > 100)) {
				deleteSensor(sensor_array, nr_sensors, i);
			}
		} else {
			power_management_unit *pmu = (power_management_unit *)
			(*sensor_array)[i].sensor_data;
			if ((pmu->voltage < 10 || pmu->voltage > 20) ||
			(pmu->current < -100 || pmu->current > 100)
			|| (pmu->power_consumption < 0 || pmu->power_consumption > 1000)
			|| (pmu->energy_regen < 0 || pmu->energy_regen > 100)
			|| (pmu->energy_storage < 0 || pmu->energy_storage > 100)) {
				deleteSensor(sensor_array, nr_sensors, i);
			}
		}
	}
}

/*
* Functie care apeleaza operatiile din vectorul de operatii
* al senzorului de la indexul respectiv
*/
void analyze(sensor *sensor_array, void (**operations)(void *),
int nr_sensors, int index)
{
	if (index < 0 || index > nr_sensors) {
		printf("Index not in range!\n");
	}
	// pentru sensor_array[index] vom efectua pe rand operatiile
	int i = 0;
	int nmr_operations = sensor_array[index].nr_operations;
	for (i = 0; i < nmr_operations; i++) {
		operations[sensor_array[index].operations_idxs[i]]
		(sensor_array[index].sensor_data);
	}
}

// Functie care elibereaza memoria unui vector de senzori
void freeSensor(sensor *sensor_array, int nr_sensors)
{
	int i = 0;
	for (i = 0; i < nr_sensors; i++) {
		free(sensor_array[i].operations_idxs);
		free(sensor_array[i].sensor_data);
	}
	free(sensor_array);
}

int main(int argc, char const *argv[])
{
	int i = 0, j = 0;
	FILE *f = fopen(argv[1], "rb");

	// sir auxiliar de care ne vom folosi sa citim instructiuni de la tastatura
	char aux[100];
	int nr_sensors = 0;
	fread(&nr_sensors, sizeof(int), 1, f);

	sensor *sensor_array = (sensor *) malloc(nr_sensors * sizeof(sensor));

	for (i = 0; i < nr_sensors; i++) {
		fread(&(sensor_array[i].sensor_type), sizeof(int), 1, f);

		if (sensor_array[i].sensor_type == TIRE) {
			sensor_array[i].sensor_data = (tire_sensor *)
			malloc(sizeof(tire_sensor));

			// citim campurile lui tire_sensor
			fread(sensor_array[i].sensor_data, sizeof(tire_sensor), 1, f);
		} else {
			sensor_array[i].sensor_data = (power_management_unit *)
			malloc(sizeof(power_management_unit));

			// citim campurile lui pmu
			fread(sensor_array[i].sensor_data,
			sizeof(power_management_unit), 1, f);
		}
		// citim nr_operations
		fread(&(sensor_array[i].nr_operations),
		sizeof(int), 1, f);

		sensor_array[i].operations_idxs = (int *)
		malloc(sensor_array[i].nr_operations * sizeof(int));

		for (j = 0; j < sensor_array[i].nr_operations; j++) {

			// se citeste vectorul de operatii
			fread(&(sensor_array[i].operations_idxs[j]),
			sizeof(int), 1, f);
		}
	}

	j = 0;
	// se creaza copie in care se retin senzorii in ordinea prioritatilor
	sensor *sensor_copy = (sensor *) malloc(nr_sensors * sizeof(sensor));
	for (i = 0; i < nr_sensors; i++) {
		if (sensor_array[i].sensor_type == PMU) {
			sensor_copy[j++] = sensor_array[i];
		}
	}
	for (i = 0; i < nr_sensors; i++) {
		if (sensor_array[i].sensor_type == TIRE) {
			sensor_copy[j++] = sensor_array[i];
		}
	}

	// se elibereaza vechea memorie a vectorului de senzori
	free(sensor_array);
	sensor_array = sensor_copy;

	void (*operations[8])(void *);
	get_operations((void **) operations);

	while (1) {
		fgets(aux, 100, stdin);
		if (strncmp(aux, "print", strlen("print")) == 0) {
			int n = 0;

			// se identifica intregul index si semnul lui
			char *str_aux = strchr(aux, ' ') + 1;
			char sign = 1;
			if (str_aux[0] == '-') {
				sign = -1;
				str_aux++;
			}
			while (str_aux[0] >= '0' && str_aux[0] <= '9') {
				n = n * 10 + str_aux[0] - '0';
				str_aux++;
			}

			// si se apeleaza functia
			print_simple(sensor_array, nr_sensors, n * sign);
		}
		if (strncmp(aux, "analyze", strlen("analyze")) == 0) {
			int n = 0;

			//se identifica intregul index si semnul lui
			char *str_aux = strchr(aux, ' ') + 1;
			char sign = 1;
			if (str_aux[0] == '-') {
				sign = -1;
				str_aux++;
			}
			while (str_aux[0] >= '0' && str_aux[0] <= '9') {
				n = n * 10 + str_aux[0] - '0';
				str_aux++;
			}
			//si se apeleaza functia
			analyze(sensor_array, operations, nr_sensors, n * sign);
		}
		if (strncmp(aux, "clear", strlen("clear")) == 0) {
			clear(&sensor_array, &nr_sensors);
		}
		if (strcmp(aux, "exit\n") == 0) {

			// se elibereaza memoria si se inchide fisierul
			freeSensor(sensor_array, nr_sensors);
			fclose(f);
			break;
		}
	}
	return 0;
}