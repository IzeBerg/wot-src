package net.wg.gui.notification.custom
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.custom.vo.WotPlusAttendanceVO;
   import scaleform.clik.data.DataProvider;
   
   public class WotPlusAttendanceBig extends ServiceMessageContent
   {
      
      private static const REWARDS_GAP:int = 4;
      
      private static const REWARD_IR_SIZE:int = 80;
       
      
      public var rewards:GroupEx = null;
      
      public var endTextField:TextField;
      
      public function WotPlusAttendanceBig()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonsAlign = TextFormatAlign.CENTER;
         var _loc1_:CenterAlignedGroupLayout = new CenterAlignedGroupLayout(REWARD_IR_SIZE,REWARD_IR_SIZE);
         _loc1_.gap = REWARDS_GAP;
         this.rewards.layout = _loc1_;
         this.rewards.itemRendererLinkage = "AwardItemRendererExUI";
         this.rewards.x = width >> 1;
         this.endTextField.autoSize = TextFieldAutoSize.LEFT;
         this.endTextField.multiline = true;
         this.endTextField.wordWrap = true;
      }
      
      override protected function onDispose() : void
      {
         this.rewards.dispose();
         this.rewards = null;
         this.endTextField = null;
         super.onDispose();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:WotPlusAttendanceVO = new WotPlusAttendanceVO(data.messageVO.linkageData);
         this.endTextField.htmlText = _loc1_.endText;
         this.rewards.dataProvider = new DataProvider(_loc1_.rewards);
         super.updateData();
      }
      
      override protected function get buttonsAnchorVertical() : DisplayObject
      {
         return this.endTextField;
      }
   }
}
