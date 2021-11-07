package net.wg.infrastructure.managers.impl.tutorial
{
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.ITutorialBuilder;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BuildersMap implements IDisposable
   {
       
      
      private var _buildersMap:Dictionary;
      
      public function BuildersMap()
      {
         this._buildersMap = new Dictionary();
         super();
      }
      
      public function addBuilder(param1:ITutorialBuilder, param2:String, param3:String, param4:String) : void
      {
         if(!(param2 in this._buildersMap))
         {
            this._buildersMap[param2] = new Dictionary();
         }
         if(!(param3 in this._buildersMap[param2]))
         {
            this._buildersMap[param2][param3] = new Dictionary();
         }
         this._buildersMap[param2][param3][param4] = param1;
      }
      
      public final function dispose() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this._buildersMap)
         {
            this.removeBuildersForView(_loc1_);
         }
         App.utils.data.cleanupDynamicObject(this._buildersMap);
      }
      
      public function getBuilder(param1:String, param2:String, param3:String) : ITutorialBuilder
      {
         if(!this._buildersMap[param1] || !this._buildersMap[param1][param2])
         {
            return null;
         }
         return this._buildersMap[param1][param2][param3];
      }
      
      public function getComponentBuildersDict(param1:String, param2:String) : Dictionary
      {
         if(!this._buildersMap[param1] || !this._buildersMap[param1][param2])
         {
            return null;
         }
         return this._buildersMap[param1][param2];
      }
      
      public function removeBuildersForComponent(param1:String, param2:String) : void
      {
         var _loc3_:* = null;
         if(!(param1 in this._buildersMap) || !(param2 in this._buildersMap[param1]))
         {
            return;
         }
         for(_loc3_ in this._buildersMap[param1][param2])
         {
            delete this._buildersMap[param1][param2][_loc3_];
         }
         delete this._buildersMap[param1][param2];
      }
      
      public function removeBuildersForView(param1:String) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in this._buildersMap[param1])
         {
            this.removeBuildersForComponent(param1,_loc2_);
         }
         delete this._buildersMap[param1];
      }
   }
}
