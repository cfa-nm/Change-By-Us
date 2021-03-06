/*--------------------------------------------------------------------
  Copyright (c) 2011 Local Projects. All rights reserved.
  Licensed under the Affero GNU GPL v3, see LICENSE for more details.
 --------------------------------------------------------------------*/

if (window.EnvJasmine) {
    EnvJasmine.load(EnvJasmine.jsDir + 'tc.gam.base.js');
    EnvJasmine.load(EnvJasmine.jsDir + 'tc.util.js');
    EnvJasmine.load(EnvJasmine.jsDir + 'pages/project.data.js');
    EnvJasmine.load(EnvJasmine.jsDir + 'pages/project.vol_form.js');
}

describe('project.volunteer_need_form q.js', function () {
    var vol_form_widget,
        mock_options = {
            //for merlin
            app: {
                components: {
                    modal: {}
                }
            },
            //project specific data
            project_data: {
                info: {
                    owner: { u_id: 100 }
                }
            },
            //user data
            user: {
                is_admin: false,
                is_leader: false,
                u_id: 5
            },
            //project user data
            project_user: {
                is_member: false,
                is_project_admin: false
            },
            //root directory for images and such
            media_root: 'http://cbumedia.com',
            dom: tc.jQ('body'),
            name: 'test'
        };

    beforeEach(function() {
        vol_form_widget = tc.gam.project_widgets.vol_form(mock_options);
    });

    describe('_getNextDateString', function () {
        var now = new Date(2011, 6, 1);

        it('should return a date for this year if the given month/day are after today', function() {
            expect(vol_form_widget._getNextDateString(10, 1, now)).toEqual('2011-10-1');
            expect(vol_form_widget._getNextDateString(6, 1, now)).toEqual('2011-6-1');
        });

        it('should return a date for next year if the given month/day are before today', function() {
            expect(vol_form_widget._getNextDateString(3, 1, now)).toEqual('2012-3-1');
        });
    });
});