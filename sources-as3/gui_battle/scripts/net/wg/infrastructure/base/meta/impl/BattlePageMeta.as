package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattlePageMeta extends AbstractView
   {
       
      
      private var _vectorString:Vector.<String>;
      
      private var _vectorString1:Vector.<String>;
      
      private var _vectorString2:Vector.<String>;
      
      private var _vectorString3:Vector.<String>;
      
      public function BattlePageMeta()
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
         if(this._vectorString1)
         {
            this._vectorString1.splice(0,this._vectorString1.length);
            this._vectorString1 = null;
         }
         if(this._vectorString2)
         {
            this._vectorString2.splice(0,this._vectorString2.length);
            this._vectorString2 = null;
         }
         if(this._vectorString3)
         {
            this._vectorString3.splice(0,this._vectorString3.length);
            this._vectorString3 = null;
         }
         super.onDispose();
      }
      
      public final function as_setComponentsVisibility(param1:Array, param2:Array) : void
      {
         var _loc3_:Vector.<String> = this._vectorString;
         this._vectorString = new Vector.<String>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorString[_loc5_] = param1[_loc5_];
            _loc5_++;
         }
         var _loc6_:Vector.<String> = this._vectorString1;
         this._vectorString1 = new Vector.<String>(0);
         var _loc7_:uint = param2.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            this._vectorString1[_loc8_] = param2[_loc8_];
            _loc8_++;
         }
         this.setComponentsVisibility(this._vectorString,this._vectorString1);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
         if(_loc6_)
         {
            _loc6_.splice(0,_loc6_.length);
         }
      }
      
      public final function as_setComponentsVisibilityWithFade(param1:Array, param2:Array) : void
      {
         var _loc3_:Vector.<String> = this._vectorString2;
         this._vectorString2 = new Vector.<String>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorString2[_loc5_] = param1[_loc5_];
            _loc5_++;
         }
         var _loc6_:Vector.<String> = this._vectorString3;
         this._vectorString3 = new Vector.<String>(0);
         var _loc7_:uint = param2.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            this._vectorString3[_loc8_] = param2[_loc8_];
            _loc8_++;
         }
         this.setComponentsVisibilityWithFade(this._vectorString2,this._vectorString3);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
         if(_loc6_)
         {
            _loc6_.splice(0,_loc6_.length);
         }
      }
      
      protected function setComponentsVisibility(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         var _loc3_:String = "as_setComponentsVisibility" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setComponentsVisibilityWithFade(param1:Vector.<String>, param2:Vector.<String>) : void
      {
         var _loc3_:String = "as_setComponentsVisibilityWithFade" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
