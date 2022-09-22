package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ReserveTypesUIWithFill;
   import net.wg.gui.components.tooltips.VO.ToolTipRefSysReservesVO;
   
   public class ToolTipRefSysReserves extends ToolTipSpecial
   {
      
      private static const BG_WIDTH:int = 460;
      
      private static const BG_HEIGHT:int = 235;
      
      private static const TEXT_OFFSET:int = 10;
       
      
      private var _moduleType:ReserveTypesUIWithFill = null;
      
      private var _infoTitleTF:TextField = null;
      
      private var _infoDescriptionTF:TextField = null;
      
      private var _infoLevelTF:TextField = null;
      
      private var _infoCountTF:TextField = null;
      
      private var _infoDescription1TF:TextField = null;
      
      private var _infoDescription2TF:TextField = null;
      
      private var _infoDescription3TF:TextField = null;
      
      private var _infoStatusTF:TextField = null;
      
      private var _model:ToolTipRefSysReservesVO = null;
      
      public function ToolTipRefSysReserves()
      {
         super();
         this._moduleType = content.moduleType;
         this._infoTitleTF = content.infoTitleTF;
         this._infoDescriptionTF = content.infoDescriptionTF;
         this._infoLevelTF = content.infoLevelTF;
         this._infoCountTF = content.infoCountTF;
         this._infoDescription1TF = content.infoDescription1TF;
         this._infoDescription2TF = content.infoDescription2TF;
         this._infoDescription3TF = content.infoDescription3TF;
         this._infoStatusTF = content.infoStatusTF;
      }
      
      override protected function onDispose() : void
      {
         this._moduleType = null;
         this._infoTitleTF = null;
         this._infoDescriptionTF = null;
         this._infoLevelTF = null;
         this._infoCountTF = null;
         this._infoDescription1TF = null;
         this._infoDescription2TF = null;
         this._infoDescription3TF = null;
         this._infoStatusTF = null;
         this.tryDisposeModel();
         super.onDispose();
      }
      
      override protected function redraw() : void
      {
         this.setData();
         this.updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         background.width = BG_WIDTH;
         background.height = BG_HEIGHT;
      }
      
      override protected function updatePositions() : void
      {
         this._infoDescription2TF.x = this._infoDescription3TF.x = this._infoDescription1TF.x + this._infoDescription1TF.textWidth + TEXT_OFFSET;
         super.updatePositions();
      }
      
      private function tryDisposeModel() : void
      {
         if(this._model != null)
         {
            this._model.dispose();
            this._model = null;
         }
      }
      
      private function setData() : void
      {
         this.tryDisposeModel();
         this._model = new ToolTipRefSysReservesVO(_data);
         var _loc1_:String = this._model.moduleLabel + (this._model.level > ReserveTypesUIWithFill.LEVELS_WITHOUT_GLOW ? ReserveTypesUIWithFill.GLOW_BIG_ENDING : ReserveTypesUIWithFill.NO_GLOW_BIG_ENDING);
         this._moduleType.setModuleTypeIcon(_loc1_);
         this._infoTitleTF.htmlText = this._model.infoTitle;
         this._infoDescriptionTF.htmlText = this._model.infoDescription;
         this._infoLevelTF.htmlText = this._model.infoLevel;
         this._infoCountTF.htmlText = this._model.infoCount;
         this._infoDescription1TF.htmlText = this._model.infoDescription1;
         this._infoDescription2TF.htmlText = this._model.infoDescription2;
         this._infoDescription3TF.htmlText = this._model.infoDescription3;
         this._infoStatusTF.htmlText = this._model.infoStatus;
      }
   }
}
