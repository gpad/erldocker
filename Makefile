APPS := lager
ACTIVE_APPS := sasl,gproc,erlfsmon,compiler,crypto,syntax_tools,tools,rebar,active
ERLDOCKER_APPS := asn1,crypto,public_key,ssl,mimetypes,hackney,jsx,erldocker

ERL_FLAGS= +sbwt none +swct lazy +swt high +K true

all: deps compile

deps:
	./rebar get-deps
	./rebar compile

compile: deps
	./rebar skip_deps=true compile

shell: compile
	ERL_LIBS=deps erl -pa ebin -config config/sys.config -sname erldocker -s erldocker_app $(ERL_FLAGS)

.PHONY: run compile shell
