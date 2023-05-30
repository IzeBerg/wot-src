package net.wg.gui.lobby.profile.pages.awards
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
   import scaleform.clik.constants.DirectionMode;
   
   public class AwardsBlock extends AwardsTileListBlock
   {
      
      private static const BG_PADDING:uint = 75;
       
      
      public var background:MovieClip;
      
      private var _showProgress:Boolean = true;
      
      private var _currentCount:uint;
      
      protected var _totalCount:uint;
      
      public function AwardsBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         tileList.direction = DirectionMode.VERTICAL;
         tileList.columnCount = 12;
      }
      
      override protected function applyLabel() : void
      {
         textField.htmlText = labelText + "<font color=\'#8c8c7e\' size=\'14\'> (" + this._currentCount + "/" + this._totalCount + ")</font>";
      }
      
      public function get showProgress() : Boolean
      {
         return this._showProgress;
      }
      
      public function set showProgress(param1:Boolean) : void
      {
         this._showProgress = param1;
         invalidate(LABEL_INV);
      }
      
      override protected function applySizeChanges() : void
      {
         var _loc1_:Number = Math.round(tileList.y + tileList.height + BG_PADDING);
         this.background.y = Math.round(_loc1_ - this.background.height);
         _height = _loc1_;
      }
      
      public function set totalCount(param1:uint) : void
      {
         this._totalCount = param1;
         invalidate(LABEL_INV);
      }
      
      public function set currentCount(param1:uint) : void
      {
         this._currentCount = param1;
         invalidate(LABEL_INV);
      }
   }
}
