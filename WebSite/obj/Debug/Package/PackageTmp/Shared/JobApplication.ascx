<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="JobApplication.ascx.cs" Inherits="WebSite.Shared.JobApplication" %>
<%@ Import Namespace="Tools" %>

<div class="home8-contact-form default-box-shadow1 bdrs12 bdr1 p30 mb30-md bgc-white">
    <h4 class="form-title mb25"><%= Language.GetSite(56) %></h4>
    <div class="form-style1">
        <div class="row">
            <div class="col-lg-6">
                <div class="mb20">
                    <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(35) %></label>
                    <input type="text" id="FirstName" data-field="First Name" placeholder="<%= Language.GetSite(35) %>" class="form-control cnt-form-data" required />
                </div>
            </div>
            <div class="col-lg-6">
                <div class="mb20">
                    <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(36) %></label>
                    <input type="text" id="LastName" data-field="Last Name" placeholder="<%= Language.GetSite(36) %>" class="form-control cnt-form-data" required />
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb20">
                    <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(6) %></label>
                    <input type="email" id="Email" data-field="Email" class="form-control cnt-form-data" placeholder="<%= Language.GetSite(6) %>" required />
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb20">
                    <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(45) %></label>
                    <input type="text" id="Phone" data-field="Phone" class="form-control cnt-form-data" placeholder="<%= Language.GetSite(45) %>" required />
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb20">
                    <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(57) %></label>
                    <select id="Subject" data-field="Subject" class="form-control cnt-form-data" placeholder="<%= Language.GetSite(57) %>" required>
                        <option>Please choose</option>
                        <option>Brand Expert</option>
                        <option>Architect</option>
                        <option>Human Resources Manager</option>
                        <option>Civil Engineer - Technical</option>
                    </select>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb20">
                    <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(58) %></label>
                    <input type="file" id="Resume" data-field="Resume" class="form-control cnt-form-data" placeholder="<%= Language.GetSite(58) %>" required />
                </div>
            </div>
            <div class="col-md-12">
                <div class="mb10">
                    <label class="heading-color ff-heading fw600 mb10"><%= Language.GetSite(41) %></label>
                    <textarea id="Message" data-field="Message" class="cnt-form-data" cols="30" rows="4" placeholder="<%= Language.GetSite(41) %>"></textarea>
                </div>
            </div>
            <div class="col-md-12">
                <div class="d-grid">
                    <a href="javascript:;" title="<%= Language.GetSite(42) %>" data-prefix="cnt" data-formid="1" class="ud-btn btn-thm btn-send-data">
                        <%= Language.GetSite(42) %><i class="fal fa-arrow-right-long"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>