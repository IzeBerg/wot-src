package net.wg.gui.lobby.storage.categories.blueprints
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.lobby.storage.categories.cards.BlueprintCardCostVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BlueprintCostRenderer extends UIComponentEx
   {
       
      
      public var costTF:TextField = null;
      
      public var delimeter:Sprite = null;
      
      private var _costData:BlueprintCardCostVO = null;
      
      public function BlueprintCostRenderer()
      {
         super();
         mouseChildren = mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         this.costTF = null;
         this.delimeter = null;
         this._costData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._costData && isInvalid(InvalidationType.DATA))
         {
            this.costTF.htmlText = this._costData.costStr;
            invalidateSize();
         }
         if(this._costData && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this._costData.hasDelimeter;
            App.utils.commons.updateTextFieldSize(this.costTF,true,false);
            this.delimeter.visible = _loc1_;
            if(_loc1_)
            {
               this.delimeter.x = this.costTF.width + this._costData.delimeterOffset;
            }
         }
      }
      
      public function updateCostData(param1:BlueprintCardCostVO) : void
      {
         this._costData = param1;
         invalidateData();
      }
   }
}
