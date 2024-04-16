package net.wg.gui.lobby.training
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.helpers.DropListDelegate;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class TrainingDragDelegate extends DropListDelegate
   {
       
      
      public function TrainingDragDelegate(param1:InteractiveObject, param2:String)
      {
         super(param1,param2);
      }
      
      [Event(name="onStartDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:IUpdatable = null;
         if(super.onStartDrop(param1,param2,param3,param4))
         {
            if(App.instance && param2 is IDropItem)
            {
               _loc5_ = App.cursor.getAttachedSprite() as IUpdatable;
               if(_loc5_)
               {
                  App.utils.asserter.assertNotNull(_loc5_,"cursor.attachedSprite" + Errors.CANT_NULL);
                  IUpdatable(_loc5_).update(IDropItem(param2).data);
                  return true;
               }
               DebugUtils.LOG_ERROR("attached sprite must implements IUpdatable interface.");
            }
         }
         if(App.cursor.getAttachedSprite() is IDisposable)
         {
            IDisposable(App.cursor.getAttachedSprite()).dispose();
            App.cursor.detachFromCursor();
         }
         return false;
      }
   }
}
