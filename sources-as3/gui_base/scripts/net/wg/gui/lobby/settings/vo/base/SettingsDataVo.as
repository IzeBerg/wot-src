package net.wg.gui.lobby.settings.vo.base
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SettingsDataVo extends DAAPIDataClass
   {
       
      
      public var keys:Vector.<String> = null;
      
      public var values:Vector.<Object> = null;
      
      public function SettingsDataVo(param1:Object = null)
      {
         this.keys = new Vector.<String>();
         this.values = new Vector.<Object>();
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc4_:int = 0;
         if(this.keys)
         {
            this.keys.splice(0,this.keys.length);
            this.keys = null;
         }
         var _loc1_:int = this.values.length;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            if(this.values[_loc3_] is IDisposable)
            {
               this.values[_loc3_].dispose();
            }
            if(this.values[_loc3_] is Array || this.values[_loc3_] is Vector)
            {
               _loc2_ = this.values[_loc3_].length;
               _loc4_ = 0;
               while(_loc4_ < _loc2_)
               {
                  if(this.values[_loc3_][_loc4_] is IDisposable)
                  {
                     this.values[_loc3_][_loc4_].dispose();
                  }
                  _loc4_++;
               }
               this.values[_loc3_].splice(0,this.values[_loc3_].length);
            }
            this.values[_loc3_] = null;
            _loc3_++;
         }
         this.values.splice(0,this.values.length);
         this.values = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         this.keys.push(param1);
         this.values.push(param2);
         return hasOwnProperty(param1);
      }
      
      public function createControl(param1:String) : ControlsFactory
      {
         return ControlsFactory.instance.createControl(param1);
      }
      
      public function createSliderWithLabelAndValue() : ControlsFactory
      {
         return this.createControl(ControlsFactory.TYPE_SLIDER).hasLabel(true).hasValue(true);
      }
      
      public function getByKey(param1:String) : Object
      {
         return this.values[this.keys.indexOf(param1)];
      }
      
      public function setByKey(param1:String, param2:Object) : void
      {
         var _loc3_:int = this.keys.indexOf(param1);
         App.utils.asserter.assert(_loc3_ != -1,this + ":setByKey - cant find \'" + param1 + "\' field.");
         this.values[_loc3_] = param2;
      }
   }
}
