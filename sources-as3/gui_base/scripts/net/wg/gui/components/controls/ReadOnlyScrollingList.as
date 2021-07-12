package net.wg.gui.components.controls
{
   import scaleform.clik.events.InputEvent;
   
   public class ReadOnlyScrollingList extends ScrollingListEx
   {
       
      
      public function ReadOnlyScrollingList()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG ReadOnlyScrollingList " + name + "]";
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
      }
   }
}
