package net.wg.gui.lobby.questsWindow.components
{
   import net.wg.gui.lobby.questsWindow.data.BaseResizableContentVO;
   import net.wg.gui.lobby.questsWindow.data.EventsResizableContentVO;
   import net.wg.infrastructure.interfaces.ISortable;
   
   public class EventsResizableContent extends AnimResizableContent implements ISortable
   {
       
      
      public function EventsResizableContent()
      {
         super();
      }
      
      override protected function castData(param1:Object) : BaseResizableContentVO
      {
         return new EventsResizableContentVO(param1);
      }
   }
}
