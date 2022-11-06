package net.wg.gui.lobby.questsWindow.data
{
   public class TreeContentVO extends BaseResizableContentVO
   {
       
      
      private var _isResizable:Boolean = true;
      
      private var _isOpened:Boolean = false;
      
      private var _headerHtmlPart:String = "";
      
      public function TreeContentVO(param1:Object)
      {
         super(param1);
      }
      
      public function get isOpened() : Boolean
      {
         return this._isOpened;
      }
      
      public function set isOpened(param1:Boolean) : void
      {
         this._isOpened = param1;
      }
      
      public function get isResizable() : Boolean
      {
         return this._isResizable;
      }
      
      public function set isResizable(param1:Boolean) : void
      {
         this._isResizable = param1;
      }
      
      public function get headerHtmlPart() : String
      {
         return this._headerHtmlPart;
      }
      
      public function set headerHtmlPart(param1:String) : void
      {
         this._headerHtmlPart = param1;
      }
   }
}
