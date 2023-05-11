package net.wg.gui.lobby.rankedBattles19.view
{
   import flash.display.InteractiveObject;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.interfaces.IViewStackExPaddingContent;
   import scaleform.clik.utils.Padding;
   
   public class RankedBattlesViewStackComponent extends BaseDAAPIComponent implements IViewStackExPaddingContent
   {
       
      
      protected var INV_VIEW_PADDING:String = "invalidateViewPadding";
      
      private var _viewPadding:Padding;
      
      public function RankedBattlesViewStackComponent()
      {
         this._viewPadding = new Padding();
         super();
      }
      
      override protected function onDispose() : void
      {
         this._viewPadding = null;
         super.onDispose();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function setActive(param1:Boolean) : void
      {
      }
      
      public function setSizePadding(param1:Padding, param2:Boolean) : void
      {
         if(this._viewPadding == param1)
         {
            return;
         }
         this._viewPadding = param1;
         invalidate(this.INV_VIEW_PADDING);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      protected function get viewPadding() : Padding
      {
         return this._viewPadding;
      }
   }
}
