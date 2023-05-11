package net.wg.gui.lobby.profile.pages.total
{
   import flash.display.InteractiveObject;
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   import net.wg.gui.lobby.components.IResizableContent;
   
   public class ProfileTotalPage extends GFInjectComponent implements IResizableContent
   {
       
      
      private var _isActive:Boolean = false;
      
      public function ProfileTotalPage()
      {
         super();
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function set active(param1:Boolean) : void
      {
         this._isActive = param1;
         alpha = !!this._isActive ? Number(1) : Number(0);
         visible = this._isActive;
      }
      
      public function get active() : Boolean
      {
         return this._isActive;
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
   }
}
