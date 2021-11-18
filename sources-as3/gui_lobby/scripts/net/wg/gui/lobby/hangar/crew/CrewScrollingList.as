package net.wg.gui.lobby.hangar.crew
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class CrewScrollingList extends ScrollingListEx
   {
       
      
      public function CrewScrollingList()
      {
         super();
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:IListItemRenderer = getRendererAt(_selectedIndex,_scrollPosition);
         if(_loc2_ != null)
         {
            _loc2_.handleInput(param1);
            if(param1.handled)
            {
               return;
            }
         }
      }
   }
}
