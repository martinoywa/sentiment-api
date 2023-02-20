from app import output_formatter


def test_output_formatter():
    test = [{"label": "LABEL_1", "score": 0.5}]
    assert {"label": "Neutral", "confidence": 0.5} == output_formatter(test)
