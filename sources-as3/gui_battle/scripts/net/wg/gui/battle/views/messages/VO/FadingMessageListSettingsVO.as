package net.wg.gui.battle.views.messages.VO
{
   import net.wg.data.constants.Errors;
   
   public class FadingMessageListSettingsVO extends MessageListSettingsVO
   {
      
      private static const POOL_SETTINGS_FIELD_NAME:String = "poolSettings";
       
      
      public var maxLinesCount:int = -1;
      
      public var lifeTime:int = 0.0;
      
      public var alphaSpeed:int = 0.0;
      
      public var useHtml:Boolean = false;
      
      public var textRightPadding:Number = 0.0;
      
      public var textBottomPadding:Number = 0.0;
      
      public var showUniqueOnly:Boolean = false;
      
      public var poolSettings:Vector.<PoolSettingsVO>;
      
      public function FadingMessageListSettingsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 == POOL_SETTINGS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            if(_loc3_ == null)
            {
               App.utils.asserter.assert(false,POOL_SETTINGS_FIELD_NAME + Errors.CANT_NULL);
            }
            this.poolSettings = new Vector.<PoolSettingsVO>(_loc3_.length,true);
            _loc5_ = 0;
            for each(_loc4_ in _loc3_)
            {
               var _loc8_:* = _loc5_++;
               this.poolSettings[_loc8_] = new PoolSettingsVO(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.poolSettings)
         {
            _loc2_ = this.poolSettings.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.poolSettings[_loc1_].dispose();
               _loc1_++;
            }
            this.poolSettings.fixed = false;
            this.poolSettings.splice(0,this.poolSettings.length);
            this.poolSettings = null;
         }
         super.onDispose();
      }
   }
}
