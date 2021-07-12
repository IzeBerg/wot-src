package net.wg.gui.components.damageIndicator
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class DamageIndicatorStandardSetting implements IDisposable
   {
       
      
      public var index:int = 0;
      
      public var x:int = 0;
      
      public var y:int = 0;
      
      public var yaw:Number = 0;
      
      private var _bg:String = "";
      
      private var _blindBG:String = "";
      
      protected var _colorMgr:IColorSchemeManager = null;
      
      public function DamageIndicatorStandardSetting(param1:int, param2:String, param3:String, param4:int, param5:int, param6:Number)
      {
         super();
         this._colorMgr = App.colorSchemeMgr;
         this._bg = param2;
         this._blindBG = param3;
         this.x = param4;
         this.index = param1;
         this.y = param5;
         this.yaw = param6;
      }
      
      public final function dispose() : void
      {
         this._colorMgr = null;
      }
      
      public function getBg() : String
      {
         return !!this._colorMgr.getIsColorBlindS() ? this._blindBG : this._bg;
      }
   }
}
