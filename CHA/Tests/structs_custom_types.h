void init_cluster(struct cluster_t *c, int cap);
void clear_cluster(struct cluster_t *c);
void append_cluster(struct cluster_t *c, struct obj_t obj);
int load_clusters(char *filename, struct cluster_t **arr);
bool load_number_from_file(FILE *fr, int *number);
matrix_s *load_data_from_file(char *filename);
header_s matrix_make_header(int typ, int x, int y, int z);
int matrix_multiplication(matrix_s *A, matrix_s *B, matrix_s **C);
