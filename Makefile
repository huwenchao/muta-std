TARGET := riscv64imac-unknown-none-elf
DOCKER_IMAGE := jjy0/ckb-capsule-recipe-rust:2020-5-9

ci: fmt test

fmt:
	cargo fmt --all -- --check

test:
	make -C test test

publish-in-docker:
		docker run --rm -it -v `pwd`:/code -v `pwd`/test/contract/target/.cargo/git:/root/.cargo/git -v `pwd`/test/contract/target/.cargo/registry:/root/.cargo/registry ${DOCKER_IMAGE} bash -c 'cd /code && cargo publish --target ${TARGET} --dry-run'

.PHONY: ci fmt test