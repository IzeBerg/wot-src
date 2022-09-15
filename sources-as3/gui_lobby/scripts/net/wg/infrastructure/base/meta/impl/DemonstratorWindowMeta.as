package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class DemonstratorWindowMeta extends AbstractWindowView
   {
       
      
      public var onGameplaySelected:Function;
      
      public var onLvlSelected:Function;
      
      public var onSpawnSelected:Function;
      
      public var onMapSelected:Function;
      
      public var onBattleStart:Function;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      private var _array2:Array;
      
      public function DemonstratorWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         if(this._array2)
         {
            this._array2.splice(0,this._array2.length);
            this._array2 = null;
         }
         super.onDispose();
      }
      
      public function onGameplaySelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onGameplaySelected,"onGameplaySelected" + Errors.CANT_NULL);
         this.onGameplaySelected(param1);
      }
      
      public function onLvlSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onLvlSelected,"onLvlSelected" + Errors.CANT_NULL);
         this.onLvlSelected(param1);
      }
      
      public function onSpawnSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSpawnSelected,"onSpawnSelected" + Errors.CANT_NULL);
         this.onSpawnSelected(param1);
      }
      
      public function onMapSelectedS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onMapSelected,"onMapSelected" + Errors.CANT_NULL);
         this.onMapSelected(param1);
      }
      
      public function onBattleStartS() : void
      {
         App.utils.asserter.assertNotNull(this.onBattleStart,"onBattleStart" + Errors.CANT_NULL);
         this.onBattleStart();
      }
      
      public final function as_setGameplayTabs(param1:Array, param2:int) : void
      {
         var _loc3_:Array = this._array;
         this._array = param1;
         this.setGameplayTabs(this._array,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      public final function as_setSpawns(param1:Array, param2:int) : void
      {
         var _loc3_:Array = this._array1;
         this._array1 = param1;
         this.setSpawns(this._array1,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      public final function as_setLevels(param1:Array, param2:int) : void
      {
         var _loc3_:Array = this._array2;
         this._array2 = param1;
         this.setLevels(this._array2,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function setGameplayTabs(param1:Array, param2:int) : void
      {
         var _loc3_:String = "as_setGameplayTabs" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setSpawns(param1:Array, param2:int) : void
      {
         var _loc3_:String = "as_setSpawns" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setLevels(param1:Array, param2:int) : void
      {
         var _loc3_:String = "as_setLevels" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
