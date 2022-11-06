package net.wg.gui.components.battleRoyale.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ConfiguratorColumnVO extends DAAPIDataClass
   {
      
      private static const MODULES_LBL:String = "modules";
       
      
      public var index:int = -1;
      
      public var headerIcon:String = "";
      
      public var headerText:String = "";
      
      public var selected:Boolean = false;
      
      public var highlighted:Boolean = false;
      
      public var availableForSelection:Boolean = false;
      
      public var gap:int = 0;
      
      private var _moduleVOs:Vector.<ConfiguratorModuleVO>;
      
      public function ConfiguratorColumnVO(param1:Object)
      {
         this._moduleVOs = new Vector.<ConfiguratorModuleVO>();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         if(param1 == MODULES_LBL)
         {
            _loc3_ = param2 as Array;
            if(_loc3_ != null)
            {
               this.clearModules();
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this._moduleVOs.push(new ConfiguratorModuleVO(_loc3_[_loc5_]));
                  _loc5_++;
               }
            }
            else
            {
               App.utils.asserter.assert(false,Errors.INVALID_TYPE + Array);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.clearModules();
         this._moduleVOs = null;
         super.onDispose();
      }
      
      public function updateStates(param1:ConfiguratorColumnVO) : void
      {
         var _loc3_:ConfiguratorModuleVO = null;
         var _loc6_:ConfiguratorModuleVO = null;
         this.selected = param1.selected;
         this.highlighted = param1.highlighted;
         this.availableForSelection = param1.availableForSelection;
         var _loc2_:Vector.<ConfiguratorModuleVO> = param1.moduleVOs;
         var _loc4_:uint = _loc2_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc2_[_loc5_];
            for each(_loc6_ in this._moduleVOs)
            {
               if(_loc6_.intCD == _loc3_.intCD)
               {
                  _loc6_.update(_loc3_);
                  break;
               }
            }
            _loc5_++;
         }
      }
      
      private function clearModules() : void
      {
         var _loc1_:ConfiguratorModuleVO = null;
         for each(_loc1_ in this._moduleVOs)
         {
            _loc1_.dispose();
         }
         this._moduleVOs.splice(0,this._moduleVOs.length);
      }
      
      public function get moduleVOs() : Vector.<ConfiguratorModuleVO>
      {
         return this._moduleVOs;
      }
   }
}
