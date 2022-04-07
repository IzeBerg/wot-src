package net.wg.gui.lobby.eventBoards.components
{
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.components.interfaces.IPagination;
   import net.wg.infrastructure.base.meta.impl.PaginationMeta;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class Pagination extends PaginationMeta implements IPagination
   {
       
      
      public var leftBtn:ISoundButtonEx = null;
      
      public var rightBtn:ISoundButtonEx = null;
      
      public var valueTF:TextField = null;
      
      public function Pagination()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.leftBtn.addEventListener(ButtonEvent.CLICK,this.onLeftClickHandler);
         this.rightBtn.addEventListener(ButtonEvent.CLICK,this.onRightClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.leftBtn.removeEventListener(ButtonEvent.CLICK,this.onLeftClickHandler);
         this.leftBtn.dispose();
         this.leftBtn = null;
         this.rightBtn.removeEventListener(ButtonEvent.CLICK,this.onRightClickHandler);
         this.rightBtn.dispose();
         this.rightBtn = null;
         this.valueTF = null;
         super.onDispose();
      }
      
      public function as_setPage(param1:String) : void
      {
         this.valueTF.htmlText = param1;
      }
      
      public function as_setEnabled(param1:Boolean, param2:Boolean) : void
      {
         this.leftBtn.enabled = param1;
         this.rightBtn.enabled = param2;
      }
      
      public function paginationEnabled() : Boolean
      {
         return this.leftBtn.enabled || this.rightBtn.enabled;
      }
      
      private function onLeftClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            showPageS(-1);
         }
      }
      
      private function onRightClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            showPageS(1);
         }
      }
   }
}
