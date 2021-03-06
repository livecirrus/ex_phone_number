defmodule ExPhoneNumber.NormalizationSpec do
  use Pavlov.Case, async: true

  doctest ExPhoneNumber.Normalization
  import ExPhoneNumber.Normalization

  describe ".convert_alpha_chars_in_number" do
    context "1-800-ABC" do
      subject do: "1800-ABC-DEF"

      it "returns correct value" do
        assert "1800-222-333" == convert_alpha_chars_in_number(subject)
      end
    end
  end

  describe ".normalize" do
    context "number with puntuaction" do
      subject do: "034-56&+#2\u00AD34"

      it "returns correct value" do
        assert "03456234" == normalize(subject)
      end
    end

    context "number with alpha chars" do
      subject do: "034-I-am-HUNGRY"

      it "returns correct value" do
        assert "034426486479" == normalize(subject)
      end
    end

    context "number with unicode digits" do
      subject do: "\uFF125\u0665"

      it "returns correct value" do
        assert "255" == normalize(subject)
      end
    end

    context "number with eastern-arabic digits" do
      subject do: "\u06F52\u06F0"

      it "returns correct value" do
        assert "520" == normalize(subject)
      end
    end
  end

  describe "normalize_digits_only" do
    context "number with alpha chars and puntuaction" do
      subject do: "034-56&+a#234"

      it "returns correct value" do
        assert "03456234" == normalize_digits_only(subject)
      end
    end
  end
end
