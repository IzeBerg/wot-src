package net.wg.gui.lobby.questsWindow.components
{
   import net.wg.gui.lobby.questsWindow.components.interfaces.IResizableContent;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class AbstractResizableContent extends UIComponentEx implements IResizableContent
   {
       
      
      private var _isReadyForLayout:Boolean = false;
      
      private var _leftPadding:int = 0;
      
      private var _contentAlign:String = "left";
      
      private var _availableWidth:Number = 0;
      
      private var _isNumerated:Boolean = false;
      
      public function AbstractResizableContent()
      {
         super();
      }
      
      public function setData(param1:Object) : void
      {
      }
      
      public function get isReadyForLayout() : Boolean
      {
         return this._isReadyForLayout;
      }
      
      public function set isReadyForLayout(param1:Boolean) : void
      {
         this._isReadyForLayout = param1;
      }
      
      public function get leftPadding() : int
      {
         return this._leftPadding;
      }
      
      public function set leftPadding(param1:int) : void
      {
         this._leftPadding = param1;
      }
      
      public function get availableWidth() : Number
      {
         return this._availableWidth;
      }
      
      public function set availableWidth(param1:Number) : void
      {
         this._availableWidth = param1;
      }
      
      public function get contentAlign() : String
      {
         return this._contentAlign;
      }
      
      public function set contentAlign(param1:String) : void
      {
         this._contentAlign = param1;
      }
      
      public function get isNumerated() : Boolean
      {
         return this._isNumerated;
      }
      
      public function set isNumerated(param1:Boolean) : void
      {
         this._isNumerated = param1;
      }
   }
}
