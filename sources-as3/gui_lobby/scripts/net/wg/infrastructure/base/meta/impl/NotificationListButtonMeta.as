package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class NotificationListButtonMeta extends BaseDAAPIComponent
   {
       
      
      public var handleClick:Function;
      
      public function NotificationListButtonMeta()
      {
         super();
      }
      
      public function handleClickS() : void
      {
         App.utils.asserter.assertNotNull(this.handleClick,"handleClick" + Errors.CANT_NULL);
         this.handleClick();
      }
   }
}
