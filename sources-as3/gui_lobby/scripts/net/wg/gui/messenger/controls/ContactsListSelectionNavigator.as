package net.wg.gui.messenger.controls
{
   import net.wg.gui.components.controls.listselection.AbstractListSelectionNavigator;
   import net.wg.gui.messenger.data.ContactsListTreeItemInfo;
   
   public class ContactsListSelectionNavigator extends AbstractListSelectionNavigator
   {
      
      private static const ID:String = "id";
       
      
      public function ContactsListSelectionNavigator()
      {
         super();
      }
      
      override protected function isSelectable(param1:int) : Boolean
      {
         var _loc3_:ContactsListTreeItemInfo = null;
         var _loc2_:Object = getItemByIndex(param1);
         if(_loc2_ is ContactsListTreeItemInfo)
         {
            _loc3_ = ContactsListTreeItemInfo(_loc2_);
            if(_loc3_.isBrunch)
            {
               return _loc3_.parent != null;
            }
            return _loc3_.gui[ID] != null;
         }
         return false;
      }
   }
}
