package net.wg.infrastructure.managers.utils.impl
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import net.wg.utils.IPopUpManager;
   import net.wg.utils.IUtils;
   import net.wg.utils.helpLayout.PopupLayoutVO;
   import scaleform.clik.managers.PopUpManager;
   
   public class PopupManager implements IPopUpManager
   {
       
      
      public function PopupManager()
      {
         super();
      }
      
      public function contains(param1:DisplayObject) : Boolean
      {
         return this.popupCanvas.contains(param1);
      }
      
      public function create(param1:String, param2:PopupLayoutVO = null) : DisplayObject
      {
         var _loc3_:DisplayObject = App.utils.classFactory.getComponent(param1,DisplayObject) as DisplayObject;
         App.utils.asserter.assertNotNull(_loc3_,"object for \'" + param1 + "\' was not found.");
         if(param2 != null)
         {
            this.show(_loc3_,param2.x,param2.y,param2.scope);
         }
         else
         {
            this.show(_loc3_);
         }
         return _loc3_;
      }
      
      public function remove(param1:DisplayObject, param2:Boolean = true) : void
      {
         App.utils.asserter.assertNotNull(param1,"You cannot remove popup with null value!");
         if(param2)
         {
            App.utils.commons.releaseReferences(param1);
         }
         if(this.contains(param1))
         {
            this.popupCanvas.removeChild(param1);
         }
      }
      
      public function removeAll() : void
      {
         var _loc3_:DisplayObject = null;
         var _loc1_:DisplayObjectContainer = this.popupCanvas;
         var _loc2_:IUtils = App.utils;
         while(_loc1_.numChildren)
         {
            _loc3_ = _loc1_.getChildAt(_loc1_.numChildren - 1);
            _loc2_.commons.releaseReferences(_loc3_);
            _loc1_.removeChild(_loc3_);
         }
      }
      
      public function show(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:DisplayObjectContainer = null) : void
      {
         var _loc5_:MovieClip = MovieClip(App.instance);
         PopUpManager.show(param1,param2 - _loc5_.x,param3 - _loc5_.y,param4);
      }
      
      public function get popupCanvas() : DisplayObjectContainer
      {
         return PopUpManager.popupCanvas;
      }
   }
}
