package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.battleDamagePanel.models.MessageRenderModel;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleDamageLogPanelMeta extends BaseDAAPIComponent
   {
       
      
      private var _vectorMessageRenderModel:Vector.<MessageRenderModel>;
      
      private var _vectorMessageRenderModel1:Vector.<MessageRenderModel>;
      
      public function BattleDamageLogPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MessageRenderModel = null;
         var _loc2_:MessageRenderModel = null;
         if(this._vectorMessageRenderModel)
         {
            for each(_loc1_ in this._vectorMessageRenderModel)
            {
               _loc1_.dispose();
            }
            this._vectorMessageRenderModel.splice(0,this._vectorMessageRenderModel.length);
            this._vectorMessageRenderModel = null;
         }
         if(this._vectorMessageRenderModel1)
         {
            for each(_loc2_ in this._vectorMessageRenderModel1)
            {
               _loc2_.dispose();
            }
            this._vectorMessageRenderModel1.splice(0,this._vectorMessageRenderModel1.length);
            this._vectorMessageRenderModel1 = null;
         }
         super.onDispose();
      }
      
      public final function as_detailStatsTop(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         var _loc7_:MessageRenderModel = null;
         var _loc4_:Vector.<MessageRenderModel> = this._vectorMessageRenderModel;
         this._vectorMessageRenderModel = new Vector.<MessageRenderModel>(0);
         var _loc5_:uint = param3.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this._vectorMessageRenderModel[_loc6_] = new MessageRenderModel(param3[_loc6_]);
            _loc6_++;
         }
         this.detailStatsTop(param1,param2,this._vectorMessageRenderModel);
         if(_loc4_)
         {
            for each(_loc7_ in _loc4_)
            {
               _loc7_.dispose();
            }
            _loc4_.splice(0,_loc4_.length);
         }
      }
      
      public final function as_detailStatsBottom(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         var _loc7_:MessageRenderModel = null;
         var _loc4_:Vector.<MessageRenderModel> = this._vectorMessageRenderModel1;
         this._vectorMessageRenderModel1 = new Vector.<MessageRenderModel>(0);
         var _loc5_:uint = param3.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            this._vectorMessageRenderModel1[_loc6_] = new MessageRenderModel(param3[_loc6_]);
            _loc6_++;
         }
         this.detailStatsBottom(param1,param2,this._vectorMessageRenderModel1);
         if(_loc4_)
         {
            for each(_loc7_ in _loc4_)
            {
               _loc7_.dispose();
            }
            _loc4_.splice(0,_loc4_.length);
         }
      }
      
      protected function detailStatsTop(param1:Boolean, param2:Boolean, param3:Vector.<MessageRenderModel>) : void
      {
         var _loc4_:String = "as_detailStatsTop" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
      
      protected function detailStatsBottom(param1:Boolean, param2:Boolean, param3:Vector.<MessageRenderModel>) : void
      {
         var _loc4_:String = "as_detailStatsBottom" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc4_);
         throw new AbstractException(_loc4_);
      }
   }
}
