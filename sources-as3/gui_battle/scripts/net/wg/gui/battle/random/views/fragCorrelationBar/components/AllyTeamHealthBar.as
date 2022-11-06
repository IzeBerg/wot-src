package net.wg.gui.battle.random.views.fragCorrelationBar.components
{
   import flash.text.TextField;
   import net.wg.data.constants.FragCorrelationBarStatus;
   import net.wg.data.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class AllyTeamHealthBar extends BaseTeamHealthBar
   {
      
      private static const HP_BAR_TO_DIFF_TF_OFFSET:int = -6;
       
      
      public var diffHpTF:TextField = null;
      
      private var _diffValue:String = "";
      
      private var _showDiffValue:Boolean = false;
      
      public function AllyTeamHealthBar()
      {
         super();
         TextFieldEx.setNoTranslate(this.diffHpTF,false);
      }
      
      override public function setViewSettings(param1:int) : void
      {
         super.setViewSettings(param1);
         var _loc2_:Boolean = FragCorrelationBarStatus.isShowHPDifferenceValues(param1);
         if(_loc2_ == this._showDiffValue)
         {
            return;
         }
         this._showDiffValue = _loc2_;
         invalidatePosition();
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.diffHpTF = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            if(this._showDiffValue)
            {
               if(!this.diffHpTF.visible)
               {
                  this.diffHpTF.visible = true;
               }
               this.diffHpTF.x = hpBar.x - getHealthBarWidth() + HP_BAR_TO_DIFF_TF_OFFSET - this.diffHpTF.width;
            }
            else if(this.diffHpTF.visible)
            {
               this.diffHpTF.visible = false;
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._showDiffValue)
            {
               this.diffHpTF.text = this._diffValue;
            }
         }
      }
      
      public function setDiffValues(param1:String) : void
      {
         if(param1 == this._diffValue)
         {
            return;
         }
         this._diffValue = param1;
         invalidateData();
      }
   }
}
