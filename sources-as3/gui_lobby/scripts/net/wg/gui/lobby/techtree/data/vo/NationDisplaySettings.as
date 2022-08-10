package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;
   
   public class NationDisplaySettings implements IValueObject
   {
      
      private static const MIN_SOURCE_ARRAY_LEN:uint = 2;
      
      private static const SOURCE_ARRAY_NODE_REND_NAME_INDEX:uint = 0;
      
      private static const SOURCE_ARRAY_LEVEL_DISPLAYED_INDEX:uint = 1;
       
      
      private var _nodeRendererName:String;
      
      private var _isLevelDisplayed:Boolean;
      
      private var _disposed:Boolean = false;
      
      public function NationDisplaySettings(param1:String = "", param2:Boolean = false)
      {
         super();
         this._nodeRendererName = param1;
         this._isLevelDisplayed = param2;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void
      {
         if(param1.length >= MIN_SOURCE_ARRAY_LEN)
         {
            this._nodeRendererName = Boolean(param1[SOURCE_ARRAY_NODE_REND_NAME_INDEX]) ? param1[SOURCE_ARRAY_NODE_REND_NAME_INDEX] : "";
            this._isLevelDisplayed = Boolean(param1[SOURCE_ARRAY_LEVEL_DISPLAYED_INDEX]);
         }
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.nodeRendererName != null)
         {
            this._nodeRendererName = param1.nodeRendererName;
         }
         if(param1.isLevelDisplayed != null)
         {
            this._isLevelDisplayed = param1.isLevelDisplayed;
         }
      }
      
      public function toString() : String
      {
         return "[NationDisplaySettings: nodeRendererName = " + this._nodeRendererName + ", isLevelDisplayed = " + this._isLevelDisplayed + " ]";
      }
      
      public function get nodeRendererName() : String
      {
         return this._nodeRendererName;
      }
      
      public function get isLevelDisplayed() : Boolean
      {
         return this._isLevelDisplayed;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
