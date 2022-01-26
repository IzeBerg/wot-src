package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.components.controls.SoundButtonEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class PremiumShopButton extends SoundButtonEx
   {
      
      private static const BTN_NAME:String = "rendererBtn";
      
      private static const BTN_NAME_SEPARATOR:String = "_";
       
      
      private var _row:int = 0;
      
      private var _column:int = 0;
      
      private var _level:int = 0;
      
      public function PremiumShopButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHtmlText = true;
         mouseEnabledOnDisabled = true;
         dynamicSizeByText = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            name = BTN_NAME + this._column + BTN_NAME_SEPARATOR + this._row;
         }
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function get row() : int
      {
         return this._row;
      }
      
      public function set row(param1:int) : void
      {
         this._row = param1;
         invalidateData();
      }
      
      public function get column() : int
      {
         return this._column;
      }
      
      public function set column(param1:int) : void
      {
         this._column = param1;
         invalidateData();
      }
   }
}
