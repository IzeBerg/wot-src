package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class ContactsTreeComponentMeta extends BaseDAAPIComponent
   {
       
      
      public var onGroupSelected:Function;
      
      public var searchLocalContact:Function;
      
      public var hasDisplayingContacts:Function;
      
      public function ContactsTreeComponentMeta()
      {
         super();
      }
      
      public function onGroupSelectedS(param1:int, param2:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onGroupSelected,"onGroupSelected" + Errors.CANT_NULL);
         this.onGroupSelected(param1,param2);
      }
      
      public function searchLocalContactS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.searchLocalContact,"searchLocalContact" + Errors.CANT_NULL);
         this.searchLocalContact(param1);
      }
      
      public function hasDisplayingContactsS() : Boolean
      {
         App.utils.asserter.assertNotNull(this.hasDisplayingContacts,"hasDisplayingContacts" + Errors.CANT_NULL);
         return this.hasDisplayingContacts();
      }
   }
}
