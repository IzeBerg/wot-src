package net.wg.gui.lobby.questsWindow.data
{
   public class EventsResizableContentVO extends TreeContentVO
   {
       
      
      private var _headerProgress:Object = null;
      
      private var _tablePadding:int = 0;
      
      private var _showDone:Boolean = false;
      
      public function EventsResizableContentVO(param1:Object)
      {
         super(param1);
      }
      
      public function get headerProgress() : Object
      {
         return this._headerProgress;
      }
      
      public function set headerProgress(param1:Object) : void
      {
         this._headerProgress = param1;
      }
      
      public function get tablePadding() : int
      {
         return this._tablePadding;
      }
      
      public function set tablePadding(param1:int) : void
      {
         this._tablePadding = param1;
      }
      
      public function get showDone() : Boolean
      {
         return this._showDone;
      }
      
      public function set showDone(param1:Boolean) : void
      {
         this._showDone = param1;
      }
   }
}
