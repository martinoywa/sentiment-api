install:
	pip install --upgrade pip && pip install -Ur requirements.in
lint:
	pylint --disable=R,C app.py
#format-checks:
#	pycodestyle --first *.py
format-fix:
	autopep8 --in-place --aggressive --aggressive *.py
tests:
	pytest -vv test_app.py
	#python -m pytest -vv --cov=format test_app.py
all:
	make install lint format-fix tests