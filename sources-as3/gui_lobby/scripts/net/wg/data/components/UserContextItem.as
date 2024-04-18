package net.wg.data.components
{
   import net.wg.data.VO.ContextItem;
   import net.wg.infrastructure.interfaces.IContextItem;
   
   public class UserContextItem extends ContextItem
   {
       
      
      public function UserContextItem(param1:String, param2:Object = null, param3:Vector.<IContextItem> = null)
      {
         super(param1,MENU.contextmenu(param1),param2,param3);
      }
   }
}
