package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleloading.BaseBattleLoading;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RacesBattleLoadingMeta extends BaseBattleLoading
   {
       
      
      private var _vectorString:Vector.<String>;
      
      public function RacesBattleLoadingMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vectorString)
         {
            this._vectorString.splice(0,this._vectorString.length);
            this._vectorString = null;
         }
         super.onDispose();
      }
      
      public final function as_setTips(param1:Array) : void
      {
         var _loc2_:Vector.<String> = this._vectorString;
         this._vectorString = new Vector.<String>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorString[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         this.setTips(this._vectorString);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setTips(param1:Vector.<String>) : void
      {
         var _loc2_:String = "as_setTips" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
