package net.wg.gui.components.ribbon.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class RibbonSettingByType implements IDisposable
   {
       
      
      private var _color:String = "";
      
      private var _icon:String = "";
      
      private var _blindColor:String = "";
      
      private var _blindIcon:String = "";
      
      private var _countItemsInPool:int = 0;
      
      private var _colorMgr:IColorSchemeManager = null;
      
      private var _disposed:Boolean = false;
      
      public function RibbonSettingByType(param1:String, param2:String, param3:String, param4:String, param5:int)
      {
         super();
         this._colorMgr = App.colorSchemeMgr;
         this._color = param1;
         this._icon = param2;
         this._blindColor = param3;
         this._blindIcon = param4;
         this._countItemsInPool = param5;
      }
      
      public function getCurrentColor() : String
      {
         return !!this._colorMgr.getIsColorBlindS() ? this._blindColor : this._color;
      }
      
      public function getCurrentIcon() : String
      {
         return !!this._colorMgr.getIsColorBlindS() ? this._blindIcon : this._icon;
      }
      
      public function get countItemsInPool() : int
      {
         return this._countItemsInPool;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this._colorMgr = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
