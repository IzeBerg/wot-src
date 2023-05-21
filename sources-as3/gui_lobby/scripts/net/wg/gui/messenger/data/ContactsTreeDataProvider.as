package net.wg.gui.messenger.data
{
   import net.wg.data.daapi.base.DAAPIDataProvider;
   
   public class ContactsTreeDataProvider extends DAAPIDataProvider
   {
       
      
      public function ContactsTreeDataProvider()
      {
         super();
      }
      
      private static function createTreeItem(param1:Object) : ContactsListTreeItemInfo
      {
         var _loc2_:ContactsListTreeItemInfo = new ContactsListTreeItemInfo(param1);
         if(_loc2_.parentItemData != null)
         {
            _loc2_.parent = createTreeItem(_loc2_.parentItemData);
            _loc2_.parentItemData = null;
         }
         return _loc2_;
      }
      
      override public function requestItemAt(param1:uint, param2:Function = null) : Object
      {
         var _loc3_:Object = requestItemAtHandler(param1);
         var _loc4_:ContactsListTreeItemInfo = _loc3_ != null ? createTreeItem(_loc3_) : null;
         if(param2 != null)
         {
            param2(_loc4_);
         }
         return _loc4_;
      }
      
      override public function requestItemRange(param1:int, param2:int, param3:Function = null) : Array
      {
         if(!Boolean(requestItemRangeHandler))
         {
            return [];
         }
         var _loc4_:Array = [];
         var _loc5_:Array = requestItemRangeHandler(param1,param2);
         var _loc6_:uint = _loc5_.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc4_.push(createTreeItem(_loc5_[_loc7_]));
            _loc7_++;
         }
         if(param3 != null)
         {
            param3(_loc4_);
         }
         return _loc4_;
      }
   }
}
