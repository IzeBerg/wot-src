package net.wg.gui.components.advanced.screenTab
{
   import flash.display.DisplayObject;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import scaleform.clik.controls.Button;
   
   public class ScreenTabButtonBar extends ButtonBarEx
   {
       
      
      private var _allowSwapRendererForSelect:Boolean = true;
      
      public function ScreenTabButtonBar()
      {
         super();
         spacing = 10;
      }
      
      override protected function populateRendererData(param1:Button, param2:uint) : void
      {
         super.populateRendererData(param1,param2);
         if(param2 == _dataProvider.length - 1)
         {
            if(param1 is ScreenTabButton)
            {
               ScreenTabButton(param1).showLastLineItem = true;
            }
         }
         param1.validateNow();
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         if(param1 == _selectedIndex)
         {
            return;
         }
         super.selectedIndex = param1;
         if(!this._allowSwapRendererForSelect)
         {
            return;
         }
         var _loc2_:DisplayObject = _renderers[_selectedIndex];
         if(_loc2_)
         {
            _loc2_.parent.setChildIndex(_loc2_,_loc2_.parent.numChildren - 1);
         }
      }
      
      public function set allowSwapRendererForSelect(param1:Boolean) : void
      {
         this._allowSwapRendererForSelect = param1;
      }
   }
}
