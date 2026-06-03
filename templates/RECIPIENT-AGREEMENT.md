# SOURCE-CODE RECIPIENT AGREEMENT

Vergent Technology Solutions platform
Software licensed under the proprietary terms of [`LICENSE`](../LICENSE).

---

**This Agreement is made on**: ___________________________________ (date)

**Between**:

(1) **VERGENT TECHNOLOGY SOLUTIONS LTD** — a limited liability company
    incorporated in the Republic of Kenya, registered office at Nairobi
    *(the "Licensor")*; acting in this delivery through

    **RHINO ARK (KENYA) CHARITABLE TRUST** — a charitable trust
    registered in Kenya, of Karen, Nairobi *(the "Programme Operator")*,
    authorised by the Licensor to distribute the Software to Authorised
    Recipients in furtherance of the Vergent Technology Solutions;

(2) **the Recipient**:

    Name (organisation): _______________________________________________

    Registered office:   _______________________________________________

                         _______________________________________________

    Country of registration: ___________________________________________

    Primary contact:     _______________________________________________

    Primary contact email: _____________________________________________

---

## 1. The Software

The Recipient acknowledges receipt of the source-code distribution
identified as:

| Field | Value |
|---|---|
| Package name | vergent-co-ke-_____-_____.tar.gz |
| Package size (bytes) | _________________________ |
| Outer SHA-256 | __________________________________________________________ |
| Internal manifest | `MANIFEST.sha256` (verified file-by-file on extraction) |
| Date delivered | _________________________ |
| Delivery channel | ☐ Email ☐ Secure file transfer ☐ Physical media ☐ Other: _____________ |
| Encrypted (AES-256) | ☐ Yes — passphrase delivered via separate channel  ☐ No |

(Collectively, the **"Software"**.)

## 2. Authorised Purpose

The Recipient is authorised to access the Software solely for the
following purpose (the **"Authorised Purpose"**):

☐ Foundation board evaluation in connection with a proposed grant or
  endowment seeding

☐ Buyer / off-taker diligence in connection with a proposed
  carbon-credit offtake or contribution-claim agreement

☐ Independent verification (VVB pre-assessment, methodology peer
  review, or ratings-agency evaluation)

☐ Source-code escrow under a separate escrow agreement

☐ Other (specify): __________________________________________________

The Authorised Purpose terminates on:

________________________________ *(date)*  or  on completion of the
purpose stated above, whichever is earlier (the **"Term"**).

## 3. Licence terms

The Recipient is granted a non-exclusive, non-transferable, revocable,
royalty-free licence on the terms set out in the file [`LICENSE`](../LICENSE)
included in the Software distribution, which is incorporated into this
Agreement by reference.

The Recipient confirms it has read and accepts those terms in full,
including without limitation:

- the prohibitions on copying, redistribution, sub-licensing,
  reverse-engineering and the development of competing products;
- the confidentiality obligations;
- the obligation to return or destroy all copies of the Software on
  expiry or termination of the Term, with written confirmation within
  thirty (30) days; and
- the choice of Kenyan law and the exclusive jurisdiction of the
  Nairobi courts.

## 4. Authorised individuals

Only the individuals listed below may access the Software on the
Recipient's behalf. Each listed individual is bound by confidentiality
obligations equivalent to those in [`LICENSE`](../LICENSE) § 5.

| Name | Role | Email |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

If access is required for additional individuals, the Recipient will
notify the Programme Operator in writing in advance and add their names
to a signed addendum.

## 5. Integrity verification

Before relying on the Software, the Recipient shall verify:

1. The outer SHA-256 of the received `.tar.gz` (or `.tar.gz.enc`) against
   the value provided separately by the Programme Operator.

2. The internal `MANIFEST.sha256` after extraction:

   ```bash
   shasum -a 256 -c MANIFEST.sha256
   ```

   Every file should report `OK`. Any `FAILED` line must be reported to
   `info@vergent.co.ke` and `info@vergent.co.ke` before use.

## 6. Confidentiality

The Recipient shall treat the Software as confidential information and
shall not disclose its contents — including but not limited to the
methodology assumptions, pricing parameters, baseline counterfactuals,
buyer pipeline, governance structure, and forward-looking ask materials
— to any third party other than its authorised individuals (clause 4)
or its professional legal / financial advisers operating under
equivalent confidentiality obligations.

This obligation continues for five (5) years after the end of the Term.

## 7. No warranty, limitation of liability

The Software is provided "as is" without warranty. The Licensor's
liability is limited as set out in [`LICENSE`](../LICENSE) § 7.

The numerical estimates within the Software (carbon-credit volumes,
endowment projections, pricing bands, ecosystem-area figures, operational
cost lines) are indicative, pre-validation working values and do not
constitute issued carbon credits, an offer to sell, a financial
recommendation, or any binding commitment.

## 8. Termination and return

On expiry or earlier termination of the Term, the Recipient shall, within
thirty (30) days:

(a) delete or destroy all copies of the Software (electronic and
    physical, primary and backup); and

(b) send a signed written confirmation of clause 8(a) to
    `info@vergent.co.ke` and `info@vergent.co.ke`.

## 9. Governing law

This Agreement is governed by the laws of the Republic of Kenya, and the
parties submit to the exclusive jurisdiction of the courts of Nairobi.

---

## SIGNED on behalf of the Recipient

Name:        _______________________________________________

Position:    _______________________________________________

Signature:   _______________________________________________

Date:        _______________________________________________

## SIGNED on behalf of the Licensor / Programme Operator

Name:        _______________________________________________

Position:    _______________________________________________

Signature:   _______________________________________________

Date:        _______________________________________________

---

*Return the signed Agreement to* `info@vergent.co.ke` *(with copy to*
`info@vergent.co.ke`*) before the Software is opened.*
