package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   
   public class LobbyPageMeta extends AbstractView
   {
       
      
      public var moveSpace:Function;
      
      public var getSubContainerTypes:Function;
      
      public var notifyCursorOver3dScene:Function;
      
      public var notifyCursorDragging:Function;
      
      public function LobbyPageMeta()
      {
         super();
      }
      
      public function moveSpaceS(param1:Number, param2:Number, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.moveSpace,"moveSpace" + Errors.CANT_NULL);
         this.moveSpace(param1,param2,param3);
      }
      
      public function getSubContainerTypesS() : Array
      {
         App.utils.asserter.assertNotNull(this.getSubContainerTypes,"getSubContainerTypes" + Errors.CANT_NULL);
         return this.getSubContainerTypes();
      }
      
      public function notifyCursorOver3dSceneS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.notifyCursorOver3dScene,"notifyCursorOver3dScene" + Errors.CANT_NULL);
         this.notifyCursorOver3dScene(param1);
      }
      
      public function notifyCursorDraggingS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.notifyCursorDragging,"notifyCursorDragging" + Errors.CANT_NULL);
         this.notifyCursorDragging(param1);
      }
   }
}
