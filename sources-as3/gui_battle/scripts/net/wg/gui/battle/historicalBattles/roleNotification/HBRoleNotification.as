package net.wg.gui.battle.historicalBattles.roleNotification
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.meta.IHBRoleNotificationMeta;
   import net.wg.infrastructure.base.meta.impl.HBRoleNotificationMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.motion.Tween;
   
   public class HBRoleNotification extends HBRoleNotificationMeta implements IHBRoleNotificationMeta
   {
      
      private static const ALPHA_DURATION:uint = 500;
      
      private static const HIDE_DELAY:uint = 4000;
       
      
      public var roleImage:Image = null;
      
      public var roleNameTF:TextField = null;
      
      public var messageTF:TextField = null;
      
      private var _roleImage:String = "";
      
      private var _roleName:String = "";
      
      private var _message:String = "";
      
      private var _tween:Tween = null;
      
      public function HBRoleNotification()
      {
         super();
         visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._roleImage) && isInvalid(InvalidationType.DATA))
         {
            this.roleImage.source = this._roleImage;
            this.roleNameTF.text = this._roleName;
            this.messageTF.text = this._message;
            this.clearTween();
            alpha = 0;
            visible = true;
            this._tween = new Tween(ALPHA_DURATION,this,{"alpha":1},{
               "paused":false,
               "onComplete":this.onShowComplete
            });
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.roleImage.dispose();
         this.roleImage = null;
         this.roleNameTF = null;
         this.messageTF = null;
         super.onDispose();
      }
      
      public function as_show(param1:String, param2:String, param3:String) : void
      {
         if(StringUtils.isNotEmpty(param1) && StringUtils.isNotEmpty(param2) && StringUtils.isNotEmpty(param3))
         {
            this._roleImage = param1;
            this._roleName = param2;
            this._message = param3;
            invalidateData();
         }
      }
      
      private function clearTween() : void
      {
         if(this._tween != null)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onShowComplete() : void
      {
         this.clearTween();
         this._tween = new Tween(ALPHA_DURATION,this,{"alpha":0},{
            "paused":false,
            "delay":HIDE_DELAY,
            "onComplete":this.onHideComplete
         });
      }
      
      private function onHideComplete() : void
      {
         visible = false;
      }
   }
}
