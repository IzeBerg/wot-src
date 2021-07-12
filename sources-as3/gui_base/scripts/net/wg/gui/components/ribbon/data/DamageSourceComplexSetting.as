package net.wg.gui.components.ribbon.data
{
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class DamageSourceComplexSetting extends DamageSourceSetting
   {
       
      
      private var _colorMgr:IColorSchemeManager = null;
      
      private var _battleEffTypes:Vector.<String> = null;
      
      private var _normalIconPaths:Vector.<String> = null;
      
      private var _colorblindIconPaths:Vector.<String> = null;
      
      public function DamageSourceComplexSetting(param1:Vector.<String>, param2:Vector.<String>, param3:Vector.<String>)
      {
         super(Values.EMPTY_STR);
         this._colorMgr = App.colorSchemeMgr;
         this._battleEffTypes = param1;
         this._normalIconPaths = param2;
         this._colorblindIconPaths = param3;
      }
      
      override public function getCurrentIcon(param1:String) : String
      {
         var _loc2_:int = this._battleEffTypes.indexOf(param1);
         return !!this._colorMgr.getIsColorBlindS() ? this._colorblindIconPaths[_loc2_] : this._normalIconPaths[_loc2_];
      }
      
      public final function dispose() : void
      {
         this._battleEffTypes.splice(0,this._battleEffTypes.length);
         this._battleEffTypes = null;
         this._normalIconPaths.splice(0,this._normalIconPaths.length);
         this._normalIconPaths = null;
         this._colorblindIconPaths.splice(0,this._colorblindIconPaths.length);
         this._colorblindIconPaths = null;
         this._colorMgr = null;
      }
   }
}
