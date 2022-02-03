package net.wg.gui.lobby.settings.vo
{
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SettingsViewData implements IDisposable
   {
       
      
      private var _disposed:Boolean = false;
      
      private var _id:String = null;
      
      private var _data:SettingsDataVo = null;
      
      public function SettingsViewData(param1:String, param2:SettingsDataVo)
      {
         super();
         this._id = param1;
         this._data = param2;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._data = null;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get data() : SettingsDataVo
      {
         return this._data;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
