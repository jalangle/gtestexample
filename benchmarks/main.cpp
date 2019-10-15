#include <benchmark/benchmark.h>

static void BM_Example(benchmark::State& state) {
	for (auto _ : state) {
	}
}
BENCHMARK(BM_Example);

BENCHMARK_MAIN();
