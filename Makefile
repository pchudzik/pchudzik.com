HUGO_VERSION=0.83.1
NETLIFY_CLI_VERSION=8.6.23

-include credentials.sh

theme:
	(rm -rf themes && mkdir -p themes)
	(cd themes && git clone https://github.com/luizdepra/hugo-coder.git)
	(cd themes/hugo-coder && git checkout v1.1)

build:
	(rm -rf site && mkdir -p site)
	docker run --rm \
		-v $(PWD):/src \
		-v $(PWD)/site:/site \
		-e "HUGO_ENV=production" \
		--entrypoint hugo-official \
		klakegg/hugo:$(HUGO_VERSION) --minify -d /site

serve:
	docker run -it --rm -v $(PWD):/src -p 1313:1313  klakegg/hugo:0.83.1 server

deploy:
	docker run --rm \
		-e NETLIFY_AUTH_TOKEN="$(NETLIFY_AUTH_TOKEN)" \
		-e NETLIFY_SITE_ID="$(NETLIFY_SITE_ID)" \
		-v $(PWD)/site:/project \
		williamjackson/netlify-cli:$(NETLIFY_CLI_VERSION) deploy --prod --dir=/project
