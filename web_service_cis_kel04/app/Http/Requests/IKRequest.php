<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class IKRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'keterangan' => 'required|string|min:6',
            'berangkat' => 'required',
            'kembali' => 'required|after:berangkat',
            'status' => 'nullable|in:approved,pending,rejected',
        ];
    }
}
