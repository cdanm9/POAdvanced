module.exports={
    getEmailTemplate:async function(db,method,EmailTemplates){
        const {srNo,type,subject,title,content,remarks,link,closing}=await db.run(SELECT .one .from(EmailTemplates) .where({type:method}));
        let template=`<!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>PO Action Reminder</title>
        </head>
        <body style="margin: 0; padding: 0; font-family: Arial, sans-serif; background-color: #f4f4f4;">
            <table role="presentation" style="width: 100%; border-collapse: collapse;">
                <tr>
                    <td style="padding: 20px 0;">
                        <table role="presentation" style="width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                            <!-- Header -->
                            <tr>
                                <td style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 40px 30px; text-align: center;">
                                    <h1 style="margin: 0; color: #ffffff; font-size: 28px; font-weight: 600;">Action Required</h1>
                                    <p style="margin: 10px 0 0 0; color: #f0f0f0; font-size: 16px;">Purchase Order Reminder</p>
                                </td>
                            </tr>
                            
                            <!-- Content -->
                            <tr>
                                <td style="padding: 40px 30px;">
                                    <div style="text-align: center; margin-bottom: 30px;">
                                        <div style="display: inline-block; background-color: #fff3cd; border-radius: 50%; padding: 20px;">
                                            <svg width="50" height="50" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M12 8V12M12 16H12.01M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z" stroke="#856404" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                            </svg>
                                        </div>
                                    </div>
                                    
                                    <h2 style="margin: 0 0 20px 0; color: #333333; font-size: 22px; font-weight: 600; text-align: center;">Gentle Reminder</h2>
                                    
                                    <p style="margin: 0 0 20px 0; color: #555555; font-size: 16px; line-height: 1.6;">
                                        Hello,
                                    </p>
                                    
                                    <p style="margin: 0 0 20px 0; color: #555555; font-size: 16px; line-height: 1.6;">
                                        This is a friendly reminder that you have a <strong>Purchase Order pending action</strong>. Please review and take the necessary steps to move it forward.
                                    </p>
                                    
                                    <div style="background-color: #f8f9fa; border-left: 4px solid #667eea; padding: 20px; margin: 30px 0; border-radius: 4px;">
                                        <p style="margin: 0; color: #555555; font-size: 15px; line-height: 1.6;">
                                            <strong>⏰ Time-Sensitive:</strong> Your prompt attention to this matter will help ensure smooth processing and avoid any delays.
                                        </p>
                                    </div>
                                    
                                    <div style="text-align: center; margin: 35px 0;">
                                        <a href="#" style="display: inline-block; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: #ffffff; text-decoration: none; padding: 14px 40px; border-radius: 6px; font-size: 16px; font-weight: 600; box-shadow: 0 4px 6px rgba(102, 126, 234, 0.3);">
                                            View Purchase Order
                                        </a>
                                    </div>
                                    
                                    <p style="margin: 30px 0 0 0; color: #555555; font-size: 16px; line-height: 1.6;">
                                        If you have any questions or need assistance, please don't hesitate to reach out.
                                    </p>
                                </td>
                            </tr>
                            
                            <!-- Footer -->
                            <tr>
                                <td style="background-color: #f8f9fa; padding: 30px; text-align: center; border-top: 1px solid #e0e0e0;">
                                    <p style="margin: 0 0 10px 0; color: #333333; font-size: 16px; font-weight: 600;">
                                        Best Regards
                                    </p>
                                    <p style="margin: 0 0 20px 0; color: #666666; font-size: 14px;">
                                        Your Procurement Team
                                    </p>
                                    <p style="margin: 0; color: #999999; font-size: 12px; line-height: 1.5;">
                                        This is an automated reminder. Please do not reply to this email.
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </body>
        </html>`
        return {template,subject}
    }
}