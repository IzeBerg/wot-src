package net.wg.gui.lobby.quests.components
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.data.BaseAwardsBlockVO;
   import net.wg.gui.data.TaskAwardsBlockVO;
   import net.wg.gui.lobby.components.BaseAwardsBlock;
   import scaleform.gfx.TextFieldEx;
   
   public class TaskAwardsBlock extends BaseAwardsBlock
   {
       
      
      public var ribbonLoader:UILoaderAlt = null;
      
      public var awardForCompleteTF:TextField = null;
      
      public var awardReceivedTF:TextField = null;
      
      public var awardDiscountTF:TextField = null;
      
      public function TaskAwardsBlock()
      {
         super();
         hasEqualPaddings = true;
      }
      
      override public function setAwardsData(param1:BaseAwardsBlockVO) : void
      {
         super.setAwardsData(param1);
         var _loc2_:TaskAwardsBlockVO = TaskAwardsBlockVO(param1);
         this.awardForCompleteTF.visible = _loc2_.isAwardForCompleteVisible;
         this.awardReceivedTF.visible = _loc2_.isAwardsReceivedVisible;
         this.awardDiscountTF.visible = _loc2_.isAwardBonusStrVisible;
         this.awardForCompleteTF.htmlText = _loc2_.awardForCompleteText;
         this.awardReceivedTF.htmlText = _loc2_.awardReceivedText;
         this.awardDiscountTF.htmlText = _loc2_.awardBonusStrText;
         this.ribbonLoader.source = _loc2_.ribbonSource;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ribbonLoader.autoSize = false;
         TextFieldEx.setVerticalAlign(this.awardForCompleteTF,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.awardReceivedTF,TextFieldEx.VALIGN_CENTER);
         TextFieldEx.setVerticalAlign(this.awardDiscountTF,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function onDispose() : void
      {
         this.ribbonLoader.dispose();
         this.ribbonLoader = null;
         this.awardForCompleteTF = null;
         this.awardReceivedTF = null;
         this.awardDiscountTF = null;
         super.onDispose();
      }
      
      override protected function getAvailableWidth() : int
      {
         return this.ribbonLoader.width - this.awardForCompleteTF.x - this.awardForCompleteTF.width;
      }
      
      override protected function getAvailableHeight() : int
      {
         return this.ribbonLoader.height;
      }
      
      override protected function getRenderersOffsetX() : int
      {
         return this.awardForCompleteTF.x + this.awardForCompleteTF.width;
      }
   }
}
