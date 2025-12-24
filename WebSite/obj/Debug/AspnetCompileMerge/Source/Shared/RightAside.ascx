<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RightAside.ascx.cs" Inherits="WebSite.Shared.RightAside" %>
<%@ Import Namespace="Tools" %>

<div class="col-lg-4">
    <div class="column">
        <div class="default-box-shadow1 bdrs12 bdr1 p30 mb30-md bgc-white position-relative">
            <h4 class="form-title mb5"><%= Language.GetSite(59) %></h4>
            <p class="text"><%= Language.GetSite(60) %></p>
            <div class="form-style1">
                <div class="row">
                    <div class="col-md-12">
                        <div class="mb20">
                            <input id="Date" type="text" class="form-control" placeholder="Date">
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="mb20">
                            <input type="text" id="NameSurname" data-field="Full Name" placeholder="<%= Language.GetSite(61) %>" class="form-control ins-form-data" required />
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="mb20">
                            <input type="text" id="Phone" data-field="Phone" placeholder="<%= Language.GetSite(45) %>" class="form-control ins-form-data" required />
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="mb20">
                            <input type="email" id="Email" data-field="Email" class="form-control ins-form-data" placeholder="<%= Language.GetSite(6) %>" required />
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="mb10">
                            <textarea id="Message" data-field="Message" class="ins-form-data" cols="30" rows="4" placeholder="<%= Language.GetSite(41) %>" required></textarea>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="d-grid">
                            <a href="javascript:;" title="<%= Language.GetSite(42) %>" data-prefix="ins" data-formid="4" class="ud-btn btn-thm btn-send-data">
                                <%= Language.GetSite(62) %><i class="fal fa-arrow-right-long"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>