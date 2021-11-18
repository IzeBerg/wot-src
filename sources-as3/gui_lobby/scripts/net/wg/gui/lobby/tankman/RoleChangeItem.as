package net.wg.gui.lobby.tankman
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.tankman.vo.RoleChangeItemVO;
   import net.wg.infrastructure.interfaces.ISpriteEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RoleChangeItem extends Sprite implements ISpriteEx
   {
      
      private static const ALERT_OFFSET_X:int = 10;
      
      private static const ALPHA_DISABLED:Number = 0.5;
      
      private static const ALPHA_ENABLED:int = 1;
       
      
      public var radioButton:RadioButton;
      
      public var currentIcon:Sprite;
      
      public var roleIcon:UILoaderAlt;
      
      public var roleName:TextField;
      
      public var alert:AlertIco;
      
      public var disabledTipBox:Sprite;
      
      private var _tooltip:String = "";
      
      private var _alertHeader:String = "";
      
      private var _alertBody:String = "";
      
      private var _roleId:String;
      
      public function RoleChangeItem()
      {
         super();
         this.disabledTipBox.addEventListener(MouseEvent.ROLL_OVER,this.onDisabledTipBoxRollOverHandler);
         this.disabledTipBox.addEventListener(MouseEvent.ROLL_OUT,this.onDisabledTipBoxRollOutHandler);
         this.alert.addEventListener(MouseEvent.ROLL_OVER,this.onAlertRollOverHandler);
         this.alert.addEventListener(MouseEvent.ROLL_OUT,this.onAlertRollOutHandler);
      }
      
      public final function dispose() : void
      {
         this.disabledTipBox.removeEventListener(MouseEvent.ROLL_OVER,this.onDisabledTipBoxRollOverHandler);
         this.disabledTipBox.removeEventListener(MouseEvent.ROLL_OUT,this.onDisabledTipBoxRollOutHandler);
         this.alert.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertRollOverHandler);
         this.alert.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertRollOutHandler);
         this.roleIcon.dispose();
         this.roleIcon = null;
         this.roleName = null;
         this.radioButton.dispose();
         this.radioButton = null;
         this.alert.dispose();
         this.alert = null;
         this.disabledTipBox = null;
         this.currentIcon = null;
      }
      
      public function update(param1:Object) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc2_:RoleChangeItemVO = RoleChangeItemVO(param1);
         this._roleId = _loc2_.id;
         this._tooltip = _loc2_.tooltip;
         this.roleName.text = _loc2_.name;
         this.roleIcon.source = _loc2_.icon;
         _loc3_ = _loc2_.warningHeader.length > 0;
         this.alert.visible = _loc3_;
         if(_loc3_)
         {
            this.alert.x = this.roleName.x + this.roleName.textWidth + ALERT_OFFSET_X;
            this.disabledTipBox.width = this.alert.x - this.disabledTipBox.x;
            this.radioButton.width = this.alert.x - this.radioButton.x;
         }
         else
         {
            this.radioButton.width = this.roleName.x + this.roleName.textWidth;
         }
         this._alertHeader = _loc2_.warningHeader;
         this._alertBody = _loc2_.warningBody;
         this.enabled = _loc2_.available;
         _loc4_ = _loc2_.current;
         this.radioButton.visible = !_loc4_;
         this.currentIcon.visible = _loc4_;
      }
      
      public function get roleId() : String
      {
         return this._roleId;
      }
      
      public function get selected() : Boolean
      {
         return this.radioButton.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.radioButton.selected = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this.radioButton.enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this.radioButton.enabled = param1;
         var _loc2_:Number = !!param1 ? Number(ALPHA_ENABLED) : Number(ALPHA_DISABLED);
         this.roleIcon.alpha = _loc2_;
         this.roleName.alpha = _loc2_;
         this.disabledTipBox.mouseEnabled = !param1;
         this.disabledTipBox.visible = !param1;
      }
      
      private function onAlertRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onAlertRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(StringUtils.isNotEmpty(this._alertHeader))
         {
            _loc2_ = App.toolTipMgr.getNewFormatter().addHeader(this._alertHeader).addBody(this._alertBody).make();
            App.toolTipMgr.showComplex(_loc2_);
         }
      }
      
      private function onDisabledTipBoxRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onDisabledTipBoxRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._tooltip))
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }
   }
}
